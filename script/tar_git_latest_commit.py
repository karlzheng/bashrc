#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import subprocess
import sys
import tarfile
import logging
from pathlib import Path

def setup_logging():
    """配置日志记录"""
    logging.basicConfig(
        level=logging.INFO,
        format='%(asctime)s - %(levelname)s - %(message)s',
        handlers=[
            logging.StreamHandler(sys.stdout)
        ]
    )
    return logging.getLogger(__name__)

def get_latest_commit_hash():
    """获取仓库的最近一次提交哈希值"""
    logger.info("获取最近一次提交哈希值...")
    try:
        result = subprocess.run(
            ["git", "rev-parse", "HEAD"],
            capture_output=True,
            text=True,
            check=True
        )
        commit_hash = result.stdout.strip()
        logger.info(f"最近提交哈希值: {commit_hash}")
        return commit_hash
    except subprocess.CalledProcessError as e:
        logger.error(f"获取最近提交哈希值失败: {e.stderr}")
        sys.exit(1)

def get_files_in_commit(commit_hash):
    """获取指定提交中修改的文件列表"""
    logger.info(f"获取提交 {commit_hash[:8]} 中修改的文件列表...")
    try:
        result = subprocess.run(
            ["git", "diff-tree", "--no-commit-id", "--name-only", "-r", commit_hash],
            capture_output=True,
            text=True,
            check=True
        )
        files = [line for line in result.stdout.splitlines() if line.strip()]
        logger.info(f"找到 {len(files)} 个文件")
        for file_path in files:
            logger.debug(f"  - {file_path}")
        return files
    except subprocess.CalledProcessError as e:
        logger.error(f"获取提交文件列表失败: {e.stderr}")
        sys.exit(1)

def create_tarball(file_list, output_filename="latest_commit_files.tar"):
    """根据文件列表创建tar包"""
    logger.info(f"开始创建tar包: {output_filename}")
    try:
        with tarfile.open(output_filename, "w") as tar:
            for file_path in file_list:
                if os.path.exists(file_path):
                    file_size = os.path.getsize(file_path)
                    logger.info(f"添加文件: {file_path} ({file_size:,} 字节)")
                    tar.add(file_path)
                else:
                    logger.warning(f"文件不存在，跳过: {file_path}")
        logger.info(f"tar包创建完成: {output_filename}")
    except Exception as e:
        logger.error(f"创建tar包失败: {e}")
        sys.exit(1)

def main():
    global logger
    logger = setup_logging()
    
    logger.info("===== Git最近提交文件打包工具 =====")
    
    # 检查是否在git仓库中
    logger.info("检查当前目录是否为git仓库...")
    try:
        subprocess.run(["git", "rev-parse", "--is-inside-work-tree"], 
                      capture_output=True, check=True)
        logger.info("当前目录是git仓库")
    except subprocess.CalledProcessError:
        logger.error("错误: 当前目录不是git仓库")
        sys.exit(1)

    # 获取最近一次提交的哈希值
    latest_commit = get_latest_commit_hash()

    # 获取该提交中的所有文件
    files = get_files_in_commit(latest_commit)
    
    if not files:
        logger.error("错误: 最近提交中未找到文件")
        sys.exit(1)

    # 创建tar包
    create_tarball(files)
    
    logger.info("===== 操作完成 =====")

if __name__ == "__main__":
    main()    